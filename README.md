# Patchy

Apply patches from [Diffy](https://github.com/samg/diffy)

Handy if you want to just store/send minimal diffs.

```ruby
require 'diffy'
require './patchy/patch'

string1 = <<-TXT
Hello how are you
I'm fine
That's great
TXT

string2 = <<-TXT
Hello how are you
I'm fine
That's swell
TXT

diffy = Diffy::Diff.new(string1, string2, context: 0, include_diff_info: true)
patchy = Patchy::Patch.new(string1, diffy.diff)

patchy.patched == string2
```