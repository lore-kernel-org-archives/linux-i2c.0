From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: Re: [PATCH 2/4] leds: Driver for National Semiconductors LP5523
 chip
Date: Mon, 27 Sep 2010 13:54:28 +0300
Message-ID: <1285584868.8182.194.camel@masi.mnp.nokia.com>
References: <1284631946-5350-1-git-send-email-samu.p.onkalo@nokia.com>
	 <1284631946-5350-3-git-send-email-samu.p.onkalo@nokia.com>
Reply-To: matti.j.aaltonen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1284631946-5350-3-git-send-email-samu.p.onkalo@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Onkalo Samu.P (Nokia-MS/Tampere)" <samu.p.onkalo@nokia.com>
Cc: "rpurdie@linux.intel.com" <rpurdie@linux.intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Moi.

On Thu, 2010-09-16 at 12:12 +0200, Onkalo Samu.P (Nokia-MS/Tampere)
wrote:
> +
> +       for (i = 0; i < LP5523_ENGINES; i++) {
> +               if (chip->engines[i].mode == LP5523_CMD_LOAD)
> +                       sysfs_remove_group(&dev->kobj, &lp5523_engine_group[i]);
> +       }
> +
> +       for (i = 0; i < chip->num_leds; i++)
> +               sysfs_remove_group(&chip->leds[i].cdev.dev->kobj,
> +                               &lp5523_led_attribute_group);
> +}

Tossa ylla on se asia, josta puhuttiin, style guide sanoo:

Do not unnecessarily use braces where a single statement will do.

if (condition)
	action();

Tossa ylla on kummankin for:in jalkeen single statement joista kumpikaan
ei mahdu yhdelle riville... Mun nakemyksen mukaan ne molemmat olis yhta
selkeita ilman sulkuja...


> +       if (mode == LP5523_CMD_RUN)
> +               ret = lp5523_run_program(engine);
> +
> +       else if (mode == LP5523_CMD_LOAD) {
> +
> +               lp5523_set_engine_mode(engine, LP5523_CMD_DISABLED);
> +               lp5523_set_engine_mode(engine, LP5523_CMD_LOAD);
> +
> +               ret = sysfs_create_group(&dev->kobj, engine->attributes);
> +               if (ret)
> +                       return ret;
> +       }
> +

Aaltosulut myos if:n jalkeiseen statementtiin....

t.m.a.
