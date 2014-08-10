class GraphPlot
attr_reader :key, :values

  def initialize(id)
    @key=RefDatum.find(id).description
    @values = Event.hourlybreakdown.to_a
  end

end
