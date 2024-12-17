import { Route, Routes, Navigate, useLocation } from "react-router-dom";
import DriversPage from "./components/driver/DriverPage";
import VehiclesPage from "./components/vehicle/VehiclePage";
import HomePage from "./pages/HomePage";
import LoginPage from "./pages/LoginPage";
import SignUpPage from "./pages/SignUpPage";
import Sidebar from "./components/Sidebar";
import Dashboard from "./components/Dashboard";
import { useUserStore } from "./stores/useUserStore.js";
import LoadingSpinner from "./components/ui/LoadingSpinner";
import { useEffect } from "react";
import SchedulePage from "./pages/SchedulePage";

function App() {
  const { user, checkAuth, checkingAuth } = useUserStore();
  const location = useLocation();

  useEffect(() => {
    checkAuth();
  }, [checkAuth]);

  if (checkingAuth) return <LoadingSpinner />;

  // Routes where Sidebar should not appear
  const noSidebarRoutes = ["/signup", "/login", "/", "/home"];

  return (
    <div className="min-h-screen text-white overflow-hidden">
      <div className="flex min-h-screen">
        {/* Conditionally render Sidebar */}
        {!noSidebarRoutes.includes(location.pathname) && <Sidebar />}
        <div className="w-screen">
          <Routes>
            <Route path="/" element={<LoginPage />} />
            <Route path="/home" element={<HomePage />} />
            <Route path="/schedule" element={<SchedulePage />} />
            <Route path="/dashboard" element={<Dashboard />} />
            <Route
              path="/signup"
              element={!user ? <SignUpPage /> : <Navigate to="/dashboard" />}
            />
            <Route
              path="/login"
              element={!user ? <LoginPage /> : <Navigate to="/dashboard" />}
            />
            <Route path="/driversPage" element={<DriversPage />} />
            <Route path="/vehiclesPage" element={<VehiclesPage />} />
            <Route path="/addvehicle" element={<VehiclesPage />} />
            <Route path="/addriver" element={<DriversPage />} />
          </Routes>
        </div>
      </div>
    </div>
  );
}

export default App;
