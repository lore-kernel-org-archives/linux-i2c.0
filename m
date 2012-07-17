From: Matthias Urlichs <matthias-+qxcz+fHsVSELgA04lAiVw@public.gmane.org>
Subject: Re: State of arbitration and i2c_gpio?
Date: Tue, 17 Jul 2012 10:46:53 +0200
Message-ID: <20120717084653.GH11678@smurf.noris.de>
References: <loom.20120710T223443-322@post.gmane.org>
 <20120716225827.3425f4f8@endymion.delvare>
 <20120717065544.GF11678@smurf.noris.de>
 <20120717091115.44e28fd0@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120717091115.44e28fd0-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Jean Delvare:
> > They'll certainly notice that the first time they lose arbitration.
> 
> They won't notice if the code is disabled. My point was that we don't
> want to put an additional burden on single-master buses because
> arbitration is never needed for them.
> 
Checking whether Data is High after setting Clock to High is not something
I'd call a burden ...

-- 
-- Matthias Urlichs
