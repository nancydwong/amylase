class DataSource < ActiveRecord::Base
  nilify_blanks

  S3_PATH_REGEX = /\As3:\/\/[\w-]+\/.*/
  DATA_SOURCE_TYPES = %w(RedshiftS3DataSource S3DataSource)
  
  validates_presence_of :name
  validates_uniqueness_of :name

  validates_presence_of :data_source_type
  validates_inclusion_of :data_source_type, in: DATA_SOURCE_TYPES, allow_blank: false

  validates_format_of :s3_path, with: S3_PATH_REGEX, message: 'Must be a valid s3 path (e.g., s3://bucket/directory/file.txt)', allow_blank: true

  validates_presence_of :redshift_sql, if: Proc.new { |a| a.data_source_type == 'RedshiftS3DataSource' }
  validates_presence_of :s3_path, if: Proc.new { |a| a.data_source_type == 'S3DataSource' }

  has_many :data_source_collection_associations, dependent: :destroy
  has_many :data_sources, through: :data_source_collection_associations

  # Public: Gets the object for the data source type.
  attr_reader :source_type_obj

  # Public: Used to initialize data sources that need to be passed options
  def initialize_data_source_type(opts = {})
    @source_type_obj = "#{self.data_source_type}".constantize.new(self, opts || {})
  end


  # Public: Generic method used to chunk data.  This method expects a
  # block.  It will first initialize the specific data source class
  # and then call a method called 'read' in the class representing the
  # data_source_type.
  #
  # max_chunk_size - The maximum chunk size to return (kB).  In practice, this
  #                  is a rough estimate to the maximum chunk size.  If data
  #                  is streamed to chunk_it in small sizes, the resulting
  #                  chunk size should usually be half of the maximum.  If
  #                  data is streamed to chunk_it that is larger than
  #                  the maximum, it returns the same chunk that was streamed
  #                  to it.
  # block          - A block containing commands to manipulate the returned 
  #                  chunks.
  #
  # Yields an enumerator that can be used loop over chunks of data as a strings.
  def chunks(max_chunk_size: Settings.data_sources.max_chunk_size, &block)
    @source_type_obj || initialize_data_source_type

    Enumerator.new do |enum|
      chunk = ''
      @source_type_obj.read do |data|
        chunk << data
        if chunk.bytesize / 2 / 1024 > max_chunk_size
          enum.yield chunk
          chunk = ''
        end
      end
      enum.yield chunk unless chunk == ''
    end
  end
end
