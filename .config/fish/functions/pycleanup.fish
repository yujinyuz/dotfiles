function pycleanup --description "Cleanup python byte-code and cache"
  find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
end
