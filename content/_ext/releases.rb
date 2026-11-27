
# This extension expects that some files are in the _tmp directory so it can
# add their content to the site object

class Releases
  def execute(site)
    # Add a jenkins property if it doesn't already exist
    unless site.jenkins
      site.jenkins = {}
    end

    tmp_dir = File.expand_path(File.dirname(__FILE__) + '/../_tmp')

    # Something is messed up if our temporary directory doesn't exist
    unless File.exist? tmp_dir
      puts "WARNING: #{tmp_dir} not found; latest/stable version information will be unavailable"
      return
    end

    latest = File.join(tmp_dir, 'latestCore.txt')
    stable = File.join(tmp_dir, 'latestLTSCore.txt')

    if File.exist? latest
      latest_version = File.read(latest).chomp
      if latest_version =~ /^\d+\.\d+/
        site.jenkins.latest = latest_version
        site.asciidoctor.attributes['jenkins-latest'] = site.jenkins.latest
      else
        puts "WARNING: #{latest} does not contain a valid version: #{latest_version.inspect}"
      end
    end

    if File.exist? stable
      stable_version = File.read(stable).chomp
      if stable_version =~ /^\d+\.\d+/
        site.jenkins.stable = stable_version
        site.asciidoctor.attributes['jenkins-stable'] = site.jenkins.stable
      else
        puts "WARNING: #{stable} does not contain a valid version: #{stable_version.inspect}"
      end
    end
  end
end
