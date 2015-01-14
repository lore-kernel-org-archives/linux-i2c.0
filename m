From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] [RFC] i2c: Don't wait for device release in
 i2c_del_adapter
Date: Wed, 14 Jan 2015 16:15:25 +0100
Message-ID: <20150114161525.49c54acc@endymion.delvare>
References: <1421082050-10213-1-git-send-email-pantelis.antoniou@konsulko.com>
	<20150113152957.GL7660@katana>
	<20150114144938.4e3c3f52@endymion.delvare>
	<B2D57D11-FBC2-432A-90E8-90E4CF8F716C@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B2D57D11-FBC2-432A-90E8-90E4CF8F716C-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 14 Jan 2015 15:54:52 +0200, Pantelis Antoniou wrote:
> On Jan 14, 2015, at 15:49 , Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org> wrote:
> > That being said, nobody complained about this in 11 years, so I would
> > be surprised if it was plain wrong. I'd rather question the test code.
> > Where is it?
> 
> No-one has apparently tested removing an i2c mux device on a running system
> before.

I did that. On my system the i2c-i801 driver instantiates an
i2c-mux-gpio device. Unloading the i2c-i801 driver removes that device
and it works fine. Note however that I am not able to unload module
i2c-i801 immediately, I have to unload module i2c-mux-gpio first, as
the latter holds a reference to the former. This is because
i2c-mux-gpio calls i2c_get_adapter() on the parent I2C bus segment at
probing time.

I see that i2c-mux-pinctrl does the same, but i2c-mux-pca954x and
i2c-mux-pca9541 do not. This might be an issue. I doubt this is related
to your problem though, as these are module references and not device
references.

Were you able to figure out who is holding a reference to your
i2c_adapter? This would help us understand who is doing something wrong
here, i2c-core or your test code.

-- 
Jean Delvare
SUSE L3 Support
