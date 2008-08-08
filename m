From: Jean Delvare <khali@linux-fr.org>
Subject: Re: Problem with restricted I2C algorithms in kernel 2.6.26!
Date: Fri, 8 Aug 2008 11:28:53 +0200
Message-ID: <20080808112853.22adbfae@hyperion.delvare>
References: <489B6A66.40605@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755582AbYHHJ3T@vger.kernel.org>
In-Reply-To: <489B6A66.40605@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mkrufky@linuxtv.org
Cc: sam@ravnborg.org, user.kernel@gmail.com, linux-kernel@vger.kernel.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

On Thu, 7 Aug 2008 17:34:30 -0400 , mkrufky@linuxtv.org wrote:
> Jean Delvare wrote:
> > Why not, please? A vast majority of drivers work fine that way today. I
> > am still waiting for someone to give me a good reason why some other
> > drivers supposedly can't be merged upstream (something better than
> > "believe me, it's impossible".)
> 
> Nobody said that a driver "...can't be merged upstream" ...  but 
> REQUIRING a driver to be merged upstream to allow development and / or 
> testing is a problem, IMHO.
> 
> If you required that all of my development happens within a git 
> development repository, preventing me from working against distro-kernel 
> xyz, then I would simply spend more time on Windows driver development 
> and my Linux contributions would cease.

Not my goal, obviously.

> External subsystem development repositories allow us to work against 
> stable kernels at our own pace.  When driver X is ready to be merged, it 
> gets merged.
>
> With the model that you propose, "use linux-next for development" ... 
> well then what about testing?  Who is going to test my driver if it 
> requires a full kernel compile?

Some distributions do package linux-next. And this seems to be a very
easy way to get end users to test bleeding edge code. You just tell the
user to install the linux-next package and he/she's done. No need to
build anything.

-- 
Jean Delvare
