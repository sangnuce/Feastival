class Supports::Group
  attr_reader :group

  def initialize args = {}
    @group = args[:group]
  end

  def group_new
    Group.new
  end

  def all_groups
    @groups = Group.all
  end

  def message
    Message.new
  end

  def group_user arg
    arg.group_users.build
  end

  def leave user
    GroupUser.find_by user_id: user.id, group_id: @group.id
  end

  def report
    @group.reports.build
  end

  def users
    @group.users
  end

  def initalize_categories
    Category.all.map do |category|
      [category.name, category.id]
    end
  end

  def load_status
    Group.status_attributes_for_select
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
      renderAt: "chart-container-group",
      dataSource: {
        chart: {
          caption: I18n.t(".number_group_created"),
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
            seriesname: I18n.t(".number_of_group"),
            data: data
          }
        ]
      }
    )
  end

  def chart_ratio
    fail_groups = Group.fail.count
    success_group = Group.success.count

    @chart = Fusioncharts::Chart.new(
      width: "600",
      height: "400",
      type: "pie2d",
      renderAt: "chart-container-group-ratio",
      dataSource: {
        chart: {
          caption: I18n.t(".number_group_ratio"),
          subCaption: "",
          xAxisname: I18n.t(".month"),
          yAxisName: I18n.t(".count"),
          theme: "fint",
          exportEnabled: "1"
        },
        data: [
          {
            label: I18n.t(".number_of_group_success"),
            value: success_group
          },
          {
            label: I18n.t(".number_of_group_fail"),
            value: fail_groups
          }
        ]
      }
    )
  end
end
