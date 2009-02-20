From: Jean Delvare <khali@linux-fr.org>
Subject: Re: I2C query regarding baud rate
Date: Fri, 20 Feb 2009 09:36:00 +0100
Message-ID: <20090220093600.367e85f6@hyperion.delvare>
References: <aecf5e530902192209o37eea15djd24adfeaf84ca0b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758190AbZBTIga@vger.kernel.org>
In-Reply-To: <aecf5e530902192209o37eea15djd24adfeaf84ca0b0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sasa Sasa <sasak.1983@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm@vger.kernel.org, marc.pignat@hevs.ch, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Please direct I2C-related questions to the i2c-linux mailing list (now
Cc'd.)

On Fri, 20 Feb 2009 11:39:57 +0530, Sasa Sasa wrote:
> I have a query regarding the baud rate of I2C controller. Our I2C
> controller supports 3 different baud rates. So is there any possible
> or standard way for I2C clients to set this baud rate on I2C adaptor
> dynamically?

No, we do not have any way to do this at the moment. But I2C bus speed
is a tricky affair to start with. Not taking HS-I2C into account for a
moment, the I2C bus speed is a bus-wide setting, not a per-chip
setting, so letting each I2C chip driver change the bus speed doesn't
make sense. The I2C bus speed must be set once and for all according to
which devices are present on the bus (which is something only the
system designer knows.)

-- 
Jean Delvare
