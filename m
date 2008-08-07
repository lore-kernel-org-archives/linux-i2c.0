From: Jean Delvare <khali@linux-fr.org>
Subject: Re: Problem with restricted I2C algorithms in kernel 2.6.26!
Date: Thu, 7 Aug 2008 23:06:52 +0200
Message-ID: <20080807230652.20f231e4@hyperion.delvare>
References: <5ab239b10807161233i6c1c4d0we01ea1b8e6ccaa5b@mail.gmail.com>
	<20080807131357.59399ddf@hyperion.delvare>
	<20080807183944.GA29207@uranus.ravnborg.org>
	<20080807204900.1c077376@hyperion.delvare>
	<37219a840808071203y36775d8fx5cccd653da04e1fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755983AbYHGVHS@vger.kernel.org>
In-Reply-To: <37219a840808071203y36775d8fx5cccd653da04e1fc@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Krufky <mkrufky@linuxtv.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, "D. Kelly" <user.kernel@gmail.com>, "mailing list: linux-kernel" <linux-kernel@vger.kernel.org>, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

On Thu, 7 Aug 2008 15:03:36 -0400, Michael Krufky wrote:
> I agree with Trent and D.Kelly
> 
> These options should be made available to the user -- We should go
> with the patch that Jean posted, "Subject: i2c: Let users select
> algorithm drivers manually again" -- this is a fair compromise for
> both sides -- users that dont know should leave the automatic
> selection enabled.  Users that know better can disable the automatic
> selection and enable what they need.
> 
> The statement, "just have the external driver merged into the kernel"
> is not a solution.

Why not, please? A vast majority of drivers work fine that way today. I
am still waiting for someone to give me a good reason why some other
drivers supposedly can't be merged upstream (something better than
"believe me, it's impossible".)

> Removing the option to build those additional algos is a regression, IMHO

Will be addressed soon, do not worry.

-- 
Jean Delvare
