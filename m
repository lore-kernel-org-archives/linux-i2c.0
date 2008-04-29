From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 1/2 v2] i2c: Add support for device alias names
Date: Tue, 29 Apr 2008 14:49:16 +0200
Message-ID: <20080429144916.59b46313@hyperion.delvare>
References: <20080429124241.08e18ae3@hyperion.delvare>
	<20080429124621.07e6efd6@hyperion.delvare>
	<9e4733910804290516g1fd0b653jae63e811409e00f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <9e4733910804290516g1fd0b653jae63e811409e00f9@mail.gmail.com>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Paul Mundt <lethal@linux-sh.org>, Linux I2C <i2c@lm-sensors.org>, Scott Wood <scottwood@freescale.com>
List-Id: linux-i2c@vger.kernel.org

Hi Jon,

On Tue, 29 Apr 2008 08:16:13 -0400, Jon Smirl wrote:
> On 4/29/08, Jean Delvare <khali@linux-fr.org> wrote:
> > Based on earlier work by Jon Smirl and Jochen Friedrich.
> >  +/* Looks like: i2c:S */
> >  +static int do_i2c_entry(const char *filename, struct i2c_device_id *id,
> >  +                       char *alias)
> >  +{
> >  +       sprintf(alias, I2C_MODULE_PREFIX "%s", id->name);
> 
> Do you want to add the colon?

Not yet. This can be added later anyway, so I'd rather push the
known-to-work patches as is for now, and we fix this detail between rc1
and rc2. For now I am still in favor of removing the "*" we don't need,
I'll send a patch doing this later today (I hope) for discussion.

> >  +
> >  +       return 1;
> >  +}

Thanks,
-- 
Jean Delvare
