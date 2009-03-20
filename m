From: Michael Lawnick <nospam_lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH]i2c: Make test for force on client probe possible
Date: Fri, 20 Mar 2009 09:02:31 +0100
Message-ID: <49C34D97.1010603@gmx.de>
References: <49BA325D.7030308@gmx.de> <20090313130942.5addd79e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090313130942.5addd79e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Sorry for the delay, had to fix a bug in u-boot...

Jean Delvare said the following:
> Hi Michael,
> 
> I don't know how you sent this mail, but that's not OK. If you intend
> to do kernel development, you have to use a real e-mail addresses all
> along the way.
> 
Discussed in PM.

> On Fri, 13 Mar 2009 11:15:57 +0100, Michael Lawnick wrote:
>> in new driver model 'kind' is no more provided for client's probe
>> function. The driver frame work creates the path
>> sys/bus/i2c/devices/[bus]-[dev]/ and populates it with the entries
>> modalias, name, subsystem@ and uevent. If probe fails (because the
>> device is not on bus at the moment) the client's sysFs-entries are not
>> created, but the entries above remain.
> 
> This is correct, and this is by design. This is how the Linux device
> driver model works, BTW, nothing i2c-specific there.
> 
Even if this is by (current linux) design, I think it is not ok ;-)
It leaves an inconsistent (not instable) system. IMHO either the entries
should be completely removed or completely created but not that half the
way.
Should we CC another list?

-- 
Regards,
Michael
