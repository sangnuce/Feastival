class Supports::User
  attr_reader :user

  def initialize args = {}
    @user = args[:user]
  end

  def groups type
    @groups ||= type.present? ? @user.send("#{type}_groups") : @user.groups
  end

  def report
    @report = @user.reports.build
  end

  def chart
    categories = (1..Time.now.month).map do |mon|
      {label: (Time.now - (Time.now.month - mon).month).strftime("%B")}
    end
    data = (1..Time.now.month).map do |mon|
      {value: Group.created_in_time((Time.now - (Time.now.month - mon).month)
        .beginning_of_month, (Time.now - (Time.now.month - mon).month)
        .end_of_month).count}
    end

    @chart = Fusioncharts::Chart.new(
      width: "600",
      height: "400",
      type: "mscolumn2d",
      renderAt: "chart-container",
      dataSource: {
        chart: {
          caption: I18n.t(".number_user_created"),
          subCaption: "",
          xAxisname: I18n.t(".month"),
          yAxisName: I18n.t(".count"),
          theme: "fint",
          exportEnabled: "1"
        },
        categories: [{
          category: categories
        }],
        dataset: [
          {
            seriesname: I18n.t(".number_of_user"),
            data: data
          }
        ]
      }
    )
  end
end
