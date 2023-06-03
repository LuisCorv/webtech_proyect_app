require "test_helper"

class PerformanceReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @performance_report = performance_reports(:one)
  end

  test "should get index" do
    get performance_reports_url
    assert_response :success
  end

  test "should get new" do
    get new_performance_report_url
    assert_response :success
  end

  test "should create performance_report" do
    assert_difference("PerformanceReport.count") do
      post performance_reports_url, params: { performance_report: { report_date: @performance_report.report_date, user_id: @performance_report.user_id } }
    end

    assert_redirected_to performance_report_url(PerformanceReport.last)
  end

  test "should show performance_report" do
    get performance_report_url(@performance_report)
    assert_response :success
  end

  test "should get edit" do
    get edit_performance_report_url(@performance_report)
    assert_response :success
  end

  test "should update performance_report" do
    patch performance_report_url(@performance_report), params: { performance_report: { report_date: @performance_report.report_date, user_id: @performance_report.user_id } }
    assert_redirected_to performance_report_url(@performance_report)
  end

  test "should destroy performance_report" do
    assert_difference("PerformanceReport.count", -1) do
      delete performance_report_url(@performance_report)
    end

    assert_redirected_to performance_reports_url
  end
end
