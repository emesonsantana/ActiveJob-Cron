class ActiveJob::Cron::Lock < ActiveRecord::Base
  def self.acquire(name)
    already_acquired = definitely_acquired?(name)

    if already_acquired
      yield
    else
      begin
        create(:name => name) unless find_by_name(name)
      rescue ActiveRecord::StatementInvalid
        # concurrent create is okay
      end

      begin
        result = nil

        transaction do
          lock.find_by_name(name) # this is the call that will block
          acquired_lock(name)
          result = yield
        end

        result
      ensure
        maybe_released_lock(name)
      end
    end
  end

  # if true, the lock is acquired
  # if false, the lock might still be acquired, because we were in another db transaction
  def self.definitely_acquired?(name)
    !!Thread.current[:definitely_acquired_locks] and Thread.current[:definitely_acquired_locks].has_key?(name)
  end

  def self.acquired_lock(name)
    Thread.current[:definitely_acquired_locks] ||= {}
    Thread.current[:definitely_acquired_locks][name] = true
  end

  def self.maybe_released_lock(name)
    Thread.current[:definitely_acquired_locks] ||= {}
    Thread.current[:definitely_acquired_locks].delete(name)
  end

  private_class_method :acquired_lock, :maybe_released_lock

end

