class PublicActivity::ActivitiesDecorator < Draper::CollectionDecorator
  attr_writer :filter

  def filter
    @filter || "all"
  end

  def each_group &blck
    groups.each do |group|
      yield group
    end
  end

  def groups
    result = []
    decorated_objs.each_with_index do |curr, i|
      prev = i == 0 ? nil : decorated_objs[i - 1]

      if curr.groups_with? prev
        result.last << curr
      else
        curr.first = true
        result << [curr]
      end
    end
    result
  end

  def decorated_objs
    @decorated_objs ||= object.map { |a| a.decorate }
  end

  def cache_key
    key = "activities-#{filter}"

    groups.tap do |g|
      key += "-#{groups.first.first.updated_at}" unless g.empty? or g.first.empty?
    end

    key
  end
end
