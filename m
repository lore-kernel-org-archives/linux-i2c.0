From: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 08/12] mpc5121: Added I2C support.
Date: Thu, 07 May 2009 00:19:08 +0200
Message-ID: <20090506221908.3927583420E8@gemini.denx.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de> <1241640919-4650-9-git-send-email-wd@denx.de> <fa686aa40905061401k319313c5q89fd3e245c30808f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <fa686aa40905061401k319313c5q89fd3e245c30808f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, John Rigby <jcrigby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Grant Likely,

In message <fa686aa40905061401k319313c5q89fd3e245c30808f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org> you wrote:
> On Wed, May 6, 2009 at 2:15 PM, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org> wrote:
> > From: Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
> >
> > - Enabled I2C interrupts on MPC5121.
> > - Updated Kconfig for i2c-mpc driver.
> 
> I think this workaround belongs in the driver itself.

Sorry, I don't get it. Which workaround? What exactly should I change?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd-ynQEQJNshbs@public.gmane.org
Time is an illusion perpetrated by the manufacturers of space.
