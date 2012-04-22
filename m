From: viresh kumar <viresh.linux@gmail.com>
Subject: Re: [PATCH V2] i2c: designware: Add clk_{un}prepare() support
Date: Sun, 22 Apr 2012 23:08:55 +0530
Message-ID: <CAOh2x=mHS9h6kHxw2of-XWTtv35-SHRRno9Jdkb_3HuDoAovAg@mail.gmail.com>
References: <caa4a0645f80f199b31ec16de37a5c4c9c67a6fa.1334652570.git.viresh.kumar@st.com>
	<b562073871c8c3c13a1f59698f69cfdf65db3b5a.1334662366.git.viresh.kumar@st.com>
	<20120422172611.GA15041@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120422172611.GA15041@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Viresh Kumar <viresh.kumar@st.com>, ben-linux@fluff.org, spear-devel@list.st.com, khali@linux-fr.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 4/22/12, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Tue, Apr 17, 2012 at 05:04:31PM +0530, Viresh Kumar wrote:
>> clk_{un}prepare is mandatory for platforms using common clock framework.
>> Since
>> this driver is used by SPEAr platform, which supports common clock
>> framework,
>> add clk_{un}prepare() support for designware i2c.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>
> ? Can't apply, which version is this against? Looks good otherwise.

Because following is waiting in you todo list and must be applied
before this one: :)

Author: Deepak Sikri <deepak.sikri@st.com>
Date:   Mon Sep 26 18:42:10 2011 +0530

    i2c/busses: Add PM support

    This patch adds in support for standby/S2R/hybernate for
i2c-designware driver.

    Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
    Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)


Actually suspend/resume of above are also fixed by this patch.

What are your plans for following patchset:
i2c/adapter: Add bus recovery infrastructure

Would be good if you can apply that or ask for another version if you see some
shortcomings. Otherwise this kind of issues will happen again.
Please allocate some time for this, it is really important for other bus
drivers. All controllers/slaves have that bug.
They will be fixed only once this is applied. :)

--
viresh
