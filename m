From: Rabin Vincent <rabin@rab.in>
Subject: Re: i2c runtime suspend and system wide suspend
Date: Thu, 30 Dec 2010 12:02:53 +0530
Message-ID: <AANLkTinqqgNwgFCMVL-2T83zKnNLGLF007atJ4-EDEW5@mail.gmail.com>
References: <4D1C0CFE.5010008@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <4D1C0CFE.5010008@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jean Delvare <khali@linux-fr.org>, Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Vishwanath BS <vishwanath.bs@ti.com>, Partha Basak <p-basak2@ti.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 30, 2010 at 10:09 AM, Abhijeet Dharmapurikar
<adharmap@codeaurora.org> wrote:
> The i2c-core driver mixes runtime suspend and system wide suspend, in that,
> during a system wide suspend, it skips calling ->suspend if the device is
> runtime suspended.
>
> I have an interrupt controller running over the i2c bus and that driver is
> oblivious of the runtime pm framework, IOW, it doesn't do any runtime pm
> calls. CONFIG_RUNTIME_PM is enabled however (for some other bus drivers).
> The issue I am facing is that all such i2c devices are assumed runtime
> suspended and the ->suspend for these devices is not invoked during
> systemwide suspend.

This was discussed on linux-pm recently.  Rafael had a fix, I'm don't know
whether it's applied yet:

https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/029567.html
https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/029596.html

Also relevant:

https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/029600.html
https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/029658.html
