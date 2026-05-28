// 사용자 타입
export type User = {
  id: string;
  name: string;
  email: string;
  department: string;
  role: "member" | "manager" | "admin";
  createdAt: string;
};

// 보고서 타입
export type ReportType = "expense" | "weekly" | "business-trip";

export type Report = {
  id: string;
  userId: string;
  type: ReportType;
  title: string;
  content: string;
  status: "draft" | "submitted" | "approved" | "rejected";
  createdAt: string;
  updatedAt: string;
  submittedAt?: string;
  approvedAt?: string;
  approverNote?: string;
};

// 지출 보고서 상세
export type ExpenseReport = Report & {
  type: "expense";
  amount: number;
  category: string;
  receiptUrl?: string;
  description: string;
};

// 주간 업무 보고서 상세
export type WeeklyReport = Report & {
  type: "weekly";
  weekStart: string;
  weekEnd: string;
  accomplishments: string;
  nextWeekPlan: string;
};

// 출장 보고서 상세
export type BusinessTripReport = Report & {
  type: "business-trip";
  destination: string;
  tripStart: string;
  tripEnd: string;
  purpose: string;
  result: string;
  totalExpense: number;
};

// 일정 타입
export type ScheduleType = "business-trip" | "off-site";

export type Schedule = {
  id: string;
  userId: string;
  type: ScheduleType;
  title: string;
  location?: string;
  startDate: string;
  endDate: string;
  description?: string;
  createdAt: string;
};

// 팀 현황 타입
export type TeamStatus = {
  userId: string;
  userName: string;
  status: "office" | "off-site" | "business-trip";
  returnDate?: string;
  currentSchedule?: Schedule;
};
