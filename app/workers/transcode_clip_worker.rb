class TranscodeClipWorker
  include Sidekiq::Worker

  def perform(video_clip_id)
    require 'open-uri'

    et = AWS::ElasticTranscoder::Client.new

    video = Video.find_by_clip_id video_clip_id

    pipeline_id = '1414777351174-5mc7ri' # xbone-clips
    input_file_name = '%s.mp4' % [video.clip_id]
    output_file_path = '%s/' % [video.clip_id]

    preset_id_240p = '1351620000001-000061'
    preset_id_480p = '1351620000001-000020'

    job_spec = {
      :pipeline_id => pipeline_id,
      :input => {
        :key => input_file_name,
        :frame_rate   => 'auto',
        :resolution   => 'auto',
        :aspect_ratio => 'auto',
        :interlaced   => 'auto',
        :container    => 'auto'
      },
      :output_key_prefix => output_file_path,
      :outputs => [
        {
          :key       => '240p',
          :preset_id => preset_id_240p
        },
        {
          :key       => '480p',
          :preset_id => preset_id_480p
        }
      ]
    }

    et.create_job job_spec
  end
end
