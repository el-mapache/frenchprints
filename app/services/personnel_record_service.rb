class PersonnelRecordService
  def initialize(journal_id, attributes)
    @journal = Journal.find(journal_id)
    @attributes = attributes
  end

  def add_personnel_record
    @record = @journal.personnel_histories.create(@attributes)
    @record
  end
end

