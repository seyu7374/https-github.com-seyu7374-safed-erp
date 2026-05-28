-- Users 테이블
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  department VARCHAR(100),
  role VARCHAR(50) DEFAULT 'member' CHECK (role IN ('member', 'manager', 'admin')),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 보고서 테이블
CREATE TABLE reports (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type VARCHAR(50) NOT NULL CHECK (type IN ('expense', 'weekly', 'business-trip')),
  title VARCHAR(255) NOT NULL,
  content TEXT,
  status VARCHAR(50) DEFAULT 'draft' CHECK (status IN ('draft', 'submitted', 'approved', 'rejected')),
  amount DECIMAL(10, 2), -- 지출액 (expense 타입만)
  category VARCHAR(100), -- 지출 카테고리
  receipt_url TEXT, -- 영수증 URL
  description TEXT,
  week_start DATE, -- 주간 보고서 시작
  week_end DATE, -- 주간 보고서 종료
  accomplishments TEXT, -- 주간 성과
  next_week_plan TEXT, -- 다음주 계획
  destination VARCHAR(255), -- 출장지
  trip_start DATE, -- 출장 시작
  trip_end DATE, -- 출장 종료
  purpose TEXT, -- 출장 목적
  result TEXT, -- 출장 결과
  total_expense DECIMAL(10, 2), -- 출장 총 경비
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  submitted_at TIMESTAMPTZ,
  approved_at TIMESTAMPTZ,
  approver_note TEXT
);

-- 일정 테이블
CREATE TABLE schedules (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type VARCHAR(50) NOT NULL CHECK (type IN ('business-trip', 'off-site')),
  title VARCHAR(255) NOT NULL,
  location VARCHAR(255),
  start_date TIMESTAMPTZ NOT NULL,
  end_date TIMESTAMPTZ NOT NULL,
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 인덱스 생성
CREATE INDEX idx_reports_user_id ON reports(user_id);
CREATE INDEX idx_reports_type ON reports(type);
CREATE INDEX idx_reports_status ON reports(status);
CREATE INDEX idx_schedules_user_id ON schedules(user_id);
CREATE INDEX idx_schedules_type ON schedules(type);

-- RLS (Row Level Security) 활성화
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE schedules ENABLE ROW LEVEL SECURITY;

-- RLS 정책 (모든 사용자가 자신의 데이터만 접근)
CREATE POLICY "Users can view own data" ON users
  FOR SELECT USING (auth.uid()::text = id::text);

CREATE POLICY "Users can insert own reports" ON reports
  FOR INSERT WITH CHECK (auth.uid()::text = user_id::text);

CREATE POLICY "Users can view own reports" ON reports
  FOR SELECT USING (auth.uid()::text = user_id::text);

CREATE POLICY "Users can update own reports" ON reports
  FOR UPDATE USING (auth.uid()::text = user_id::text);

CREATE POLICY "Users can insert own schedules" ON schedules
  FOR INSERT WITH CHECK (auth.uid()::text = user_id::text);

CREATE POLICY "Users can view own schedules" ON schedules
  FOR SELECT USING (auth.uid()::text = user_id::text);

CREATE POLICY "Users can update own schedules" ON schedules
  FOR UPDATE USING (auth.uid()::text = user_id::text);
