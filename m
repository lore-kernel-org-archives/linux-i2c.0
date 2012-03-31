From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-dev: Add support for I2C_M_RECV_LEN
Date: Sat, 31 Mar 2012 08:19:27 +0200
Message-ID: <20120331081927.2438ea9e@endymion.delvare>
References: <20120315180835.2e669111@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120315180835.2e669111-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Douglas Gilbert <dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 15 Mar 2012 18:08:35 +0100, Jean Delvare wrote:
> As the bus driver side implementation of I2C_M_RECV_LEN is heavily
> tied to SMBus, we can't support received length over 32 bytes, but
> let's at least support that.
> 
> In practice, the caller will have to setup a buffer large enough to
> cover the case where received length byte has value 32, so minimum
> 32 + 1 = 33 bytes, possibly more if there is a fixed number of bytes
> added for the specific slave (for example a checksum.)
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Douglas Gilbert <dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>
> ---
> This is an alternative to Doug's implementation. Doug, I sent this to
> you one week ago, did you have the time to give it a try, do you have
> any comment? Again I can't test this myself so someone else will have
> to do it.

Douglas, please?

-- 
Jean Delvare
