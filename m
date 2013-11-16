From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Problem with multiple i2c multiplexers on one bus, and mux bus
 naming
Date: Sat, 16 Nov 2013 21:43:18 +0100
Message-ID: <20131116214318.1d101d35@endymion.delvare>
References: <5287B9E4.1020107@roeck-us.net>
	<20131116214116.3d035b76@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131116214116.3d035b76-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Oh, I forgot to mention...

> On Sat, 16 Nov 2013 10:31:00 -0800, Guenter Roeck wrote:
> > I understand this may require an API change, as the mux chip is not necessarily an i2c
> > and the i2c-mux core code doesn't really care what the mux chip is.

Such an API change would be perfectly acceptable. Mux drivers are few
and i2c-mux is still relatively new. Unique i2c adapter name is
something important, definitely worth changing the API if needed.

-- 
Jean Delvare
