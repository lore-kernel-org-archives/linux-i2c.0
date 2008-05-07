From: "john stultz" <johnstul@us.ibm.com>
Subject: Re: [RFC][PATCH 1/4] RTC: Class device support for persistent clock
Date: Wed, 7 May 2008 14:18:01 -0700
Message-ID: <1f1b08da0805071418q365680bexafb1996dcc77ebb0@mail.gmail.com>
References: <Pine.LNX.4.55.0805070015360.16173@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765523AbYEGVS1@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0805070015360.16173@cliff.in.clinika.pl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Jean Delvare <khali@linux-fr.org>, Ralf Baechle <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, rtc-linux@googlegroups.com, i2c@lm-sensors.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, May 6, 2008 at 5:40 PM, Maciej W. Rozycki <macro@linux-mips.org> wrote:
>  This is a generic implementation of rtc_read_persistent_clock() and
>  rtc_update_persistent_clock() suitable for platforms to be used for
>  read_persistent_clock() and update_persistent_clock() calls.  An RTC
>  device selected by the user with the RTC_HCTOSYS_DEVICE option is used.
>
>   As rtc_read_persistent_clock() is not available at the time
>  timekeeping_init() is called, it will now be disabled if the class device
>  is to be used as a reference.  In this case rtc_hctosys(), already
>  present, will be used to set up the system time at the late initcall time.
>  This call has now been rewritten to make use of
>  rtc_read_persistent_clock().

Hrmm. So how is this going to work with suspend and resume?

Ideally, on resume we want to update the clock before interrupts are
reenabled so we don't get stale time values post-resume.  For systems
that sleep on reading the persistent clock, I'm open to having them
fix it up as best they can later (partly why the code can handle
read_persistent_clock() not returning anything), but unless I'm
misreading this, it seems you're proposing to make systems that do
have a safe persistent clock have to have the window where code may
see the pre-suspend time after resume.

Am I missing something here?

thanks
-john

Maciej: Sorry for the dup, I forgot to reply to all on my first mail.
