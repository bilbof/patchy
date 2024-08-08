module Patchy
  class Patch
    attr_reader :str, :diff
    def initialize(str, diff)
      @str, @diff = str, diff
    end

    def patched
      # We call out to the unix patch lib.
      # Patch doesn't input/output stdin so we write to tmpfiles
      diffF = Tempfile.new
      diffF.write(diff)
      diffF.close

      strF = Tempfile.new
      strF.write(str)
      strF.close

      patchedF = Tempfile.new
      patchedF.close

      system("patch #{strF.path} #{diffF.path} -s -o #{patchedF.path}")
      patchedF.open.read
    ensure
      diffF.unlink
      strF.unlink
      patchedF.unlink
    end
  end
end
