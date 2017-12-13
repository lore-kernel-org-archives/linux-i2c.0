From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/6] i2c: add identifier in declarations for
 i2c_bus_recovery
Date: Wed, 13 Dec 2017 17:23:02 +0200
Message-ID: <1513178582.7000.38.camel@linux.intel.com>
References: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
         <20171204123640.3382-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:51845 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752358AbdLMP1f (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 13 Dec 2017 10:27:35 -0500
In-Reply-To: <20171204123640.3382-3-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Phil Reid <preid@electromag.com.au>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>, Andrzej Hajda <a.hajda@samsung.com>

On Mon, 2017-12-04 at 13:36 +0100, Wolfram Sang wrote:
> No reason to have them undefined, so let's add them.
> 

>  	int (*recover_bus)(struct i2c_adapter *);
>  
> -	int (*get_scl)(struct i2c_adapter *);
> -	void (*set_scl)(struct i2c_adapter *, int val);
> -	int (*get_sda)(struct i2c_adapter *);
> +	int (*get_scl)(struct i2c_adapter *adap);
> +	void (*set_scl)(struct i2c_adapter *adap, int val);
> +	int (*get_sda)(struct i2c_adapter *adap);
>  
>  	void (*prepare_recovery)(struct i2c_adapter *);
>  	void (*unprepare_recovery)(struct i2c_adapter *);

It seems inconsistent with the rest of the members even from this
visible piece.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
