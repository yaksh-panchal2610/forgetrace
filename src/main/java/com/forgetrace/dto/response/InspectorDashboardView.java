package com.forgetrace.dto.response;

import java.util.List;

public record InspectorDashboardView(
        long awaiting,
        long onHold,
        long myPassed,
        long myFailed,
        long myOnHold,
        List<BatchView> queue
) {
    public long getMyTotal() {
        return myPassed + myFailed + myOnHold;
    }

    public long getPassRatePercent() {
        long decided = myPassed + myFailed;
        return decided == 0 ? 0 : Math.round(myPassed * 100.0 / decided);
    }
}