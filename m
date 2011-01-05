From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/6] i2c-pxa: move i2c_pxa_remove to __devexit instead
	of just __exit
Date: Wed, 5 Jan 2011 12:17:31 +0000
Message-ID: <20110105121731.GG817@trinity.fluff.org>
References: <1294193110-23958-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1294193110-23958-1-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 05, 2011 at 05:05:05AM +0300, Dmitry Eremin-Solenikov wrote:
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Please write a reasonable commit message, a null or almost empty commit
message is simply unnaceptable. Please see the Documentation/SubmittingPatches
or ask more about how to write good commit messages.

Also, see Uwe's reply for a good example of how to write a commit message.

> -static int __exit i2c_pxa_remove(struct platform_device *dev)
> +static int __devexit i2c_pxa_remove(struct platform_device *dev)
>  {
>  	struct pxa_i2c *i2c = platform_get_drvdata(dev);
>  
> @@ -1169,7 +1169,7 @@ static const struct dev_pm_ops i2c_pxa_dev_pm_ops = {
>  
>  static struct platform_driver i2c_pxa_driver = {
>  	.probe		= i2c_pxa_probe,
> -	.remove		= __exit_p(i2c_pxa_remove),
> +	.remove		= __devexit_p(i2c_pxa_remove),
>  	.driver		= {
>  		.name	= "pxa2xx-i2c",
>  		.owner	= THIS_MODULE,

Right, I think this should fix any hotplug problems that you have.

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
