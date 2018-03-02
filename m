From: Phil Pokorny <ppokorny@penguincomputing.com>
Subject: Re: [PATCH] i2c: octeon: Prevent error message on bus error
Date: Fri, 2 Mar 2018 11:19:45 -0800
Message-ID: <CAAek22H_WBejypWH=GCV7iCFCaJ46HZZ=NdPtj-iaFipqATAFA@mail.gmail.com>
References: <20180227154213.3023-1-jglauber@cavium.com> <20180302101150.4mrrms3sn6spnicu@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180302101150.4mrrms3sn6spnicu@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jan Glauber <jglauber@cavium.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 2, 2018 at 2:11 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Tue, Feb 27, 2018 at 04:42:13PM +0100, Jan Glauber wrote:
> > The error message:
> >
> > [Fri Feb 16 13:42:13 2018] i2c-thunderx 0000:01:09.4: unhandled state: 0
> >
> > is mis-leading as state 0 (bus error) is not an unknown state.
> >
> > Return -EIO as before but avoid printing the message. Also rename
> > STAT_ERROR to STATE_BUS_ERROR.
> >
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
>
> Applied to for-current, thanks!

Did you also pick up the i2c-xlp9xx patches for current?

Similar set of issues there.

Multiple people have now tested them and reported they resolve issues
with IPMI SSIF on ThunderX2 platforms.

Thanks,
Phil P.

-- 
Philip Pokorny, RHCE
Chief Technology Officer
PENGUIN COMPUTING, Inc
www.penguincomputing.com

Changing the world through technical innovation
