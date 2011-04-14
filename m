From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 6/6] da8xx: enable the use of the ICPFUNC in i2c-davinci
Date: Thu, 14 Apr 2011 14:56:38 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C960196@dbde02.ent.ti.com>
References: <cover.1302031487.git.bengardiner@nanometrics.ca>
 <f1ff3f2888725a1e03541e0be5c0880f0591aea2.1302031487.git.bengardiner@nanometrics.ca>
 <B85A65D85D7EB246BE421B3FB0FBB593024C8B3C9F@dbde02.ent.ti.com>
 <BANLkTikskhqNk3NihqJ5kZhFqn1YpJEN9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTikskhqNk3NihqJ5kZhFqn1YpJEN9A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Cc: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bastian Ruppert <Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org>, Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Mike,

On Thu, Apr 14, 2011 at 04:34:34, Mike Williamson wrote:

> > The I2C driver implements a default platform data
> > so it should actually be legal for a DA8x board to
> > pass NULL platform data. In that case this line
> > will crash. You should either check for pdata to
> > be NULL or just let each board choose whether it
> > needs recovery (I think the better option).
> >
> 
> I actually had a problem with using NULL for pdata with davinci I2C
> and had submitted a patch here that sort of fell on the floor.  The
> problem was that the i2c_davinci_calc_clk_dividers is using
> platform_data without a check as described above.  So at the moment
> using NULL doesn't really work, best as I can tell...
> 
> https://lkml.org/lkml/2010/9/4/119

Looking at this mail chain, it looks like Ben was actually OK
with your first submission and just wanted you to update the
patch description saying that dev->platform_data is accessed
later in the code and that is why it needs to be updated.

I liked your first attempt better and may be you should
try another submission with the patch description updated.

Thanks,
Sekhar
