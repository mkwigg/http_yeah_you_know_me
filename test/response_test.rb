require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/response'

class ResponseTest < Minitest::Test

  def setup
    @request_lines = ["GET / HTTP/1.1",
"Host: localhost:9292",
"Connection: keep-alive",
"Cache-Control: max-age=0",
"Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
"Upgrade-Insecure-Requests: 1",
"User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.110 Safari/537.36",
"Accept-Encoding: gzip, deflate, sdch",
"Accept-Language: en-US,en;q=0.8,es;q=0.6",
"Cookie: _test_app_session=ODViUXU1R0lScmRQeFY0TWtFcndGbGdWMVdYREhyeUQvYzhwdVBOM3J6RzlMOWJ2Z01WMytyRDlrVE4zU0FPdEpBYzBqTGNNMW1oK0IyVm02eHpOQ29NOGxrOUpYSUhhcHN3My9HcGszVWVzNlBpWFhacnVRNzJRaUxacG4rUjJsbFNPS0tKeWtGN3llb2NQQmkrVE94S01NSmxrRm9sNXA4OG5JN2tHMzBWK0pxbXNha1AvOUUrNk00algwZHdOeWRXVnJLN2JSMXQ0Y2E3dmNLQkFXd3VONFRYZGg3OFFsUzN0Sll1bzkrbWRhdVlCMzZTRDZ1bUE4SnZ1c3krUG5ZUy9rRnpSVWdwZllxL1ZrTGlHREE9PS0ta0d6Q0RHeWhoVkUxUjBKRkNxdHdHZz09--0649cb9691b5c2049330e67b56ad7f3b002f96da"]
  end

  def test_it_outputs_nested_array
    output =
    [["GET / HTTP/1.1"],
  ["Host", "localhost:9292"],
  ["Connection", "keep-alive"],
  ["Cache-Control", "max-age=0"],
  ["Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"],
  ["Upgrade-Insecure-Requests", "1"],
  ["User-Agent",
   "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.110 Safari/537.36"],
  ["Accept-Encoding", "gzip, deflate, sdch"],
  ["Accept-Language", "en-US,en;q=0.8,es;q=0.6"],
  ["Cookie",
   "_test_app_session=ODViUXU1R0lScmRQeFY0TWtFcndGbGdWMVdYREhyeUQvYzhwdVBOM3J6RzlMOWJ2Z01WMytyRDlrVE4zU0FPdEpBYzBqTGNNMW1oK0IyVm02eHpOQ29NOGxrOUpYSUhhcHN3My9HcGszVWVzNlBpWFhacnVRNzJRaUxacG4rUjJsbFNPS0tKeWtGN3llb2NQQmkrVE94S01NSmxrRm9sNXA4OG5JN2tHMzBWK0pxbXNha1AvOUUrNk00algwZHdOeWRXVnJLN2JSMXQ0Y2E3dmNLQkFXd3VONFRYZGg3OFFsUzN0Sll1bzkrbWRhdVlCMzZTRDZ1bUE4SnZ1c3krUG5ZUy9rRnpSVWdwZllxL1ZrTGlHREE9PS0ta0d6Q0RHeWhoVkUxUjBKRkNxdHdHZz09--0649cb9691b5c2049330e67b56ad7f3b002f96da"]]

    assert_equal output, Response.new(@request_lines).request_to_nested_array(@request_lines)
  end

  def test_it_shifts_first_element
    hash = {"Verb"=>"GET", "Path"=>"/", "Protocol"=>"HTTP/1.1"}
    assert_equal hash, Response.new(@request_lines).first_three_hashes(@request_lines)
  end

  def test_it_deletes_first_item
    array = ["Host: localhost:9292",
    "Connection: keep-alive",
    "Cache-Control: max-age=0",
    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
    "Upgrade-Insecure-Requests: 1",
    "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.110 Safari/537.36",
    "Accept-Encoding: gzip, deflate, sdch",
    "Accept-Language: en-US,en;q=0.8,es;q=0.6",
    "Cookie: _test_app_session=ODViUXU1R0lScmRQeFY0TWtFcndGbGdWMVdYREhyeUQvYzhwdVBOM3J6RzlMOWJ2Z01WMytyRDlrVE4zU0FPdEpBYzBqTGNNMW1oK0IyVm02eHpOQ29NOGxrOUpYSUhhcHN3My9HcGszVWVzNlBpWFhacnVRNzJRaUxacG4rUjJsbFNPS0tKeWtGN3llb2NQQmkrVE94S01NSmxrRm9sNXA4OG5JN2tHMzBWK0pxbXNha1AvOUUrNk00algwZHdOeWRXVnJLN2JSMXQ0Y2E3dmNLQkFXd3VONFRYZGg3OFFsUzN0Sll1bzkrbWRhdVlCMzZTRDZ1bUE4SnZ1c3krUG5ZUy9rRnpSVWdwZllxL1ZrTGlHREE9PS0ta0d6Q0RHeWhoVkUxUjBKRkNxdHdHZz09--0649cb9691b5c2049330e67b56ad7f3b002f96da"]

    assert_equal array,
     Response.new(@request_lines).delete_first_item(@request_lines)
  end

  def test_it_outputs_hash_without_first_line
    hash = {"Host"=>"localhost:9292", "Connection"=>"keep-alive", "Cache-Control"=>"max-age=0", "Accept"=>"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests"=>"1", "User-Agent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.110 Safari/537.36", "Accept-Encoding"=>"gzip, deflate, sdch", "Accept-Language"=>"en-US,en;q=0.8,es;q=0.6", "Cookie"=>"_test_app_session=ODViUXU1R0lScmRQeFY0TWtFcndGbGdWMVdYREhyeUQvYzhwdVBOM3J6RzlMOWJ2Z01WMytyRDlrVE4zU0FPdEpBYzBqTGNNMW1oK0IyVm02eHpOQ29NOGxrOUpYSUhhcHN3My9HcGszVWVzNlBpWFhacnVRNzJRaUxacG4rUjJsbFNPS0tKeWtGN3llb2NQQmkrVE94S01NSmxrRm9sNXA4OG5JN2tHMzBWK0pxbXNha1AvOUUrNk00algwZHdOeWRXVnJLN2JSMXQ0Y2E3dmNLQkFXd3VONFRYZGg3OFFsUzN0Sll1bzkrbWRhdVlCMzZTRDZ1bUE4SnZ1c3krUG5ZUy9rRnpSVWdwZllxL1ZrTGlHREE9PS0ta0d6Q0RHeWhoVkUxUjBKRkNxdHdHZz09--0649cb9691b5c2049330e67b56ad7f3b002f96da"}

    assert_equal hash, Response.new(@request_lines).make_hash(@request_lines)
  end

  def test_it_merges_first_and_main_array
    hash1 =  {"Verb"=>"GET", "Path"=> "/", "Protocol"=>"HTTP/1.1"}
    hash2 = {"Host"=>"localhost:9292", "Connection"=>"keep-alive", "Cache-Control"=>"max-age=0", "Accept"=>"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests"=>"1", "User-Agent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.110 Safari/537.36", "Accept-Encoding"=>"gzip, deflate, sdch", "Accept-Language"=>"en-US,en;q=0.8,es;q=0.6", "Cookie"=>"_test_app_session=ODViUXU1R0lScmRQeFY0TWtFcndGbGdWMVdYREhyeUQvYzhwdVBOM3J6RzlMOWJ2Z01WMytyRDlrVE4zU0FPdEpBYzBqTGNNMW1oK0IyVm02eHpOQ29NOGxrOUpYSUhhcHN3My9HcGszVWVzNlBpWFhacnVRNzJRaUxacG4rUjJsbFNPS0tKeWtGN3llb2NQQmkrVE94S01NSmxrRm9sNXA4OG5JN2tHMzBWK0pxbXNha1AvOUUrNk00algwZHdOeWRXVnJLN2JSMXQ0Y2E3dmNLQkFXd3VONFRYZGg3OFFsUzN0Sll1bzkrbWRhdVlCMzZTRDZ1bUE4SnZ1c3krUG5ZUy9rRnpSVWdwZllxL1ZrTGlHREE9PS0ta0d6Q0RHeWhoVkUxUjBKRkNxdHdHZz09--0649cb9691b5c2049330e67b56ad7f3b002f96da"}
    hash3 = {"Verb"=>"GET", "Path"=>"/", "Protocol"=>"HTTP/1.1", "Host"=>"localhost:9292", "Connection"=>"keep-alive", "Cache-Control"=>"max-age=0", "Accept"=>"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests"=>"1", "User-Agent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.110 Safari/537.36", "Accept-Encoding"=>"gzip, deflate, sdch", "Accept-Language"=>"en-US,en;q=0.8,es;q=0.6", "Cookie"=>"_test_app_session=ODViUXU1R0lScmRQeFY0TWtFcndGbGdWMVdYREhyeUQvYzhwdVBOM3J6RzlMOWJ2Z01WMytyRDlrVE4zU0FPdEpBYzBqTGNNMW1oK0IyVm02eHpOQ29NOGxrOUpYSUhhcHN3My9HcGszVWVzNlBpWFhacnVRNzJRaUxacG4rUjJsbFNPS0tKeWtGN3llb2NQQmkrVE94S01NSmxrRm9sNXA4OG5JN2tHMzBWK0pxbXNha1AvOUUrNk00algwZHdOeWRXVnJLN2JSMXQ0Y2E3dmNLQkFXd3VONFRYZGg3OFFsUzN0Sll1bzkrbWRhdVlCMzZTRDZ1bUE4SnZ1c3krUG5ZUy9rRnpSVWdwZllxL1ZrTGlHREE9PS0ta0d6Q0RHeWhoVkUxUjBKRkNxdHdHZz09--0649cb9691b5c2049330e67b56ad7f3b002f96da"}

    assert_equal hash3, Response.new(@request_lines).merge(hash1,hash2)
  end

  def test_it_outputs_response
    response =
"Verb: GET
Path: /
Protocol: HTTP/1.1
Host: localhost:9292
Connection: keep-alive
Cache-Control: max-age=0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.110 Safari/537.36
Accept-Encoding: gzip, deflate, sdch
Accept-Language: en-US,en;q=0.8,es;q=0.6
Cookie: _test_app_session=ODViUXU1R0lScmRQeFY0TWtFcndGbGdWMVdYREhyeUQvYzhwdVBOM3J6RzlMOWJ2Z01WMytyRDlrVE4zU0FPdEpBYzBqTGNNMW1oK0IyVm02eHpOQ29NOGxrOUpYSUhhcHN3My9HcGszVWVzNlBpWFhacnVRNzJRaUxacG4rUjJsbFNPS0tKeWtGN3llb2NQQmkrVE94S01NSmxrRm9sNXA4OG5JN2tHMzBWK0pxbXNha1AvOUUrNk00algwZHdOeWRXVnJLN2JSMXQ0Y2E3dmNLQkFXd3VONFRYZGg3OFFsUzN0Sll1bzkrbWRhdVlCMzZTRDZ1bUE4SnZ1c3krUG5ZUy9rRnpSVWdwZllxL1ZrTGlHREE9PS0ta0d6Q0RHeWhoVkUxUjBKRkNxdHdHZz09--0649cb9691b5c2049330e67b56ad7f3b002f96da"
  assert_equal response, Response.new(@request_lines).output(@request_lines)
end
end
