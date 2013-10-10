require_relative '../application_manager'

describe 'ApplicationManager' do
 
  let(:application_manager) {ApplicationManager.new('2013-10-09', 12)}
  
  describe 'task_dates' do
    it 'should return an array of length eq to number of recurrings' do
      application_manager.task_dates.class.should == Array
      application_manager.task_dates.length.should == 12 
    end

    it 'should return the correct result' do
      application_manager.task_dates.should eq ["2013-11-09", "2013-12-09", "2014-01-09", "2014-02-09", "2014-03-09", "2014-04-09", "2014-05-09", "2014-06-09", "2014-07-09", "2014-08-09", "2014-09-09", "2014-10-09"] 
    end

    it 'should return the correct result for task start on 31' do
      application_manager = ApplicationManager.new('2013-10-31', 12)
      application_manager.task_dates.should eq ["2013-11-30", "2013-12-31", "2014-01-31", "2014-02-28", "2014-03-31", "2014-04-30", "2014-05-31", "2014-06-30", "2014-07-31", "2014-08-31", "2014-09-30", "2014-10-31"] 
    end
  end

  describe 'next_date' do
    it 'should return the date of recurring for the next month' do
      application_manager.next_date.should eq '2013-11-09'
    end
   
    it 'should return the last day of the next month if the day does not exist' do
      application_manager = ApplicationManager.new('2012-03-31', 12)
      application_manager.next_date.should eq '2012-04-30'
    end
  
    it 'should return the last day of the Feb. in a leap year' do
      application_manager = ApplicationManager.new('2000-01-31', 12)
      application_manager.next_date.should eq '2000-02-29'
    end
   
    it 'should return the next year when month is 12' do
      application_manager = ApplicationManager.new('2013-12-30', 12)
      application_manager.next_date.should eq '2014-01-30'
    end
  end

  describe 'feb_days' do
    it 'should return 29 when the given year is a leap year' do
      application_manager.feb_days(Date.parse('2000-10-09')).should eq 29
    end

    it 'should return 28 when the given year is not leap year' do
      application_manager.feb_days(Date.parse('2013-10-09')).should eq 28
    end
  end

end
