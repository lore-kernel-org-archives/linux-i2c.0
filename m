From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH/RFC 0/1] recover from davinci i2c time out conditions
Date: Wed, 15 Jul 2009 12:59:21 +0530
Message-ID: <1247642961.5981.77.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, "Karicheri, Muralidharan" <m-karicheri2-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch address several timeout problems that have been reported like
the one below. The kernel must be robust enough to handle such timeouts
without having to reboot the system manually. This patch has only been
tested on a DM355 hence extensive testing is required on other davinci's
as well. Hoping someone will take that up.

---

Hi Kevin,

When we do a video loopback with MT9T031, we get i2c timeouts when
application is killed using Cntrl C. Is it being addressed in any of the
patches?  We had the same issue with TI LSP releases (1.20, 2.00, 2.1o
etc).
The board has to be rebooted to recover from this.

Murali Karicheri
Software Design Engineer
Texas Instruments Inc.
Germantown, MD 20874
Phone : 301-515-3736
email: m-karicheri2-l0cyMroinI0@public.gmane.org
