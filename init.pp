class likewise_open inherits core::params {

  exec {'likewise_download:
    command => '/usr/bin/wget http://web01/software/pbis-open-8.2.2.2993.linux.x86_64.rpm.sh",
    cwd => '/tmp',
    path => '/usr/bin',
    onlyif => [ "test ! -f /tmp/pbis-open-8.2.2.2993.linux.x86_64.rpm.sh" ],
  }
  
  file { 'likewise_install_file':
    path '/tmp/pbis-open-8.2.2.2993.linux.x86_64.rpm.sh',
    require => Exec['likewise_download],
    mode => '0755',
  }
  
  exec { 'likewise_extract':
    command => 'sh /tmp/pbis-open-8.2.2.2993.linux.x86_64.rpm.sh',
    cwd => '/tmp',
    path => '/bin:/usr/bin'
    onlyif => [ "test ! -d /opt/likewise", "test =z `rpm -qa | grep ^pbius`"],
    require => File['likewise_install']
  }
  
  exec { 'like_isntall':
    command => '/bin/sh /tmp/likewise_install.sh',
    path => '/bin:/usr/bin',
    cwd => 'cwd',
    onlyif => [ 'test ! -d /opt/likewise", "test -z `rpm -qa | grep ^pbis`" ],
    require => Exec['likewise_extract'],
  }
}
