node default {
# Test message
#  notify { "Debug output on ${hostname} node.": }

}



node 'node01.example.com', 'node02.example.com', 'puppet.example.com' {
  # Test message
  # notify { "Debug output on ${hostname} node.": }

  # include jenkins

file { '/tmp/hello.txt':
  ensure  => file,
  content => "hello, planet\n",

  }
}
