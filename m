From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2/3] i2c: Convert all new-style drivers to use module
	aliasing
Date: Tue, 22 Jan 2008 11:09:51 +0100
Message-ID: <20080122110951.6d896b2b@hyperion.delvare>
References: <20080121112517.6fe35a89@hyperion.delvare>
	<20080121114139.3aaa111a@hyperion.delvare>
	<9e4733910801210850j39b9d51fy706b58ca15805f35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <9e4733910801210850j39b9d51fy706b58ca15805f35@mail.gmail.com>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jon,

On Mon, 21 Jan 2008 11:50:13 -0500, Jon Smirl wrote:
> In my version of these patches new style drivers could be loaded with
> both the driver_name/name scheme and the modalias. In these patches
> new style drivers can only be loaded via modalias. Is that what you
> intended? I'm all for making new style driver only use the modalias
> scheme.

Yes, this is what I intended. I see no point in having two ways to
achieve the same result, it makes things more complex, more costly and
possibly confusing.

I would reconsider if someone points out a very good reason to keep both
schemes in parallel.

-- 
Jean Delvare
