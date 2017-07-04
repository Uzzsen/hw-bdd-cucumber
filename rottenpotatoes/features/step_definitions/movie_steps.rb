# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.

    Movie.create(title: movie["title"], rating: movie["rating"], release_date: movie["release_date"])
  end
  #fail "Unimplemented"

end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.

  page.body.index(e1).should < page.body.index(e2) 
  #fail "Unimplemented"

end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb


#  rating_list.scan(/[A-Z]*-?\d*/).delete_if {|i| i.empty?}.each do |rating|
  rating_list.split(/, /).each do |rating|
    #debugger
  uncheck ? uncheck("ratings_" + rating) : check("ratings_" + rating)
  end
  #fail "Unimplemented"
end

Then /I should (not )?see movies with ratings: (.*)/ do |should_not, rating|
	rating_list =[]	
	rating.split(', ').each {|rting| rating_list << rting}
		
    if should_not
    rating_list.each do |rting|	
	page.find('#movies tbody').should have_no_content(/^#{rting}$/)
	end    
    else

        rating_list.each do |rting|	
        page.find('#movies tbody').should have_content(rting)
	end 
    end

end



#Then /I should not see all the movies/ do 
#  page.all('#movies').count.should == 1 end 
#Then /I should see all the movies/ do 
#  page.all('#movies tr').count.should == Movie.count + 1 end


Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table

  rows = page.body.scan(/<tr>/).length #page.all('#movies tbody tr').count

  #movie_titles = []
  #Movie.all.each {|movie| movie_titles << movie.title}
  
  expect(rows).to eq Movie.all.length+1 #movie_titles.uniq.count

  
    #   page.all('table#movies tr').count.should == (Movie.count + 1)
#	if $rows.respond_to? :should
#  rows.count.should == Movie.count
#	else
#  assert rows.count == Movie.count
#	end


#  content = page.find_by_id('movies').text
          #all_titles = movie_titles.all? do |title|
 # debugger   
     #content.include? title
          #page.has_content? title
	        #end
#debugger
         #expect(all_titles).to be true
end

