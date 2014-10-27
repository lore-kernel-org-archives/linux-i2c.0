From: Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>
Subject: Problem with multiple i2c multiplexers on the same bus
Date: Mon, 27 Oct 2014 11:46:01 -0700
Message-ID: <CAB0SmAFZ5KPpeSbQia9kq668G5kE6hpw9eBRy=59U6GOymkj9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is regarding a series of emails between Guenter Roeck and Jean
Delvare titled "Problem with multiple i2c multiplexers on one bus, and
mux bus naming" sent in November 2013. Ref:
http://thread.gmane.org/gmane.linux.drivers.i2c/16980

I'm having the same problem with multiple PCA954x multiplexers on the
same bus and there is no way to tell them apart just by looking at the
"name" file.

There was a suggestion to change the name from "i2c-N-mux (chan_id M)"
to "i2c-N-mux-XX (chan_id M)" or even "i2c-N-mux-i2c-XX (chan_id M)",
where XX is the multiplexer's i2c address. That would solve my
problem, but unfortunately it looks like Guenter never submitted the
patch (or maybe it was rejected?).

I would like to submit a similar change, but I was thinking of adding
a module parameter so that the change is not the default behavior.
The idea is to preserve backward compatibility for applications that
don't require this fix. For example, modprobe i2c-dev
explicit_mux_id=1 would use i2c-N-mux-i2c-XX (chan_id M), whereas
modprobe i2c-dev would default to the current behavior: i.e. i2c-N-mux
(chan_id M).

Any thoughts, comments?

Regards,
Martin
