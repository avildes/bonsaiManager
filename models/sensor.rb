class Sensor < ActiveRecord::Base
	def self.getChartData
		data = {}
		sensorNames = Sensor.select(:name).distinct
		sensorData = sensorNames.each do |sensor|
			sensors = Sensor.where("name = ?", sensor.name)
			data[sensor.name] = sensors.map{ |s| [s.dateMeasured, s.value] }.to_h	 
		end
		return data
	end
end