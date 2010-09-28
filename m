From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] Add ALS drivers for the apds9802als
Date: Tue, 28 Sep 2010 09:52:35 -0700
Message-ID: <1285692755.1866.66.camel@Joe-Laptop>
References: <20100928155649.17671.61810.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100928155649.17671.61810.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2010-09-28 at 16:56 +0100, Alan Cox wrote:
>  drivers/misc/apds9802als.c |  308 ++++++++++++++++++++++++++++++++++++++++++++
[]
> +static int  apds9802als_probe(struct i2c_client *client,
> +					const struct i2c_device_id *id)
> +{
> +	int res;
> +	struct als_data *data;
> +
> +	data = kzalloc(sizeof(struct als_data), GFP_KERNEL);
> +	if (data == NULL) {
> +		dev_err(&client->dev, "Memory allocation failed");

missing newline.
