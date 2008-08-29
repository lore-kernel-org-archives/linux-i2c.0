From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: s390 allmodconfig
Date: Fri, 29 Aug 2008 10:45:33 +0200
Message-ID: <20080829104533.0e65f43a@hyperion.delvare>
References: <20080829005217.509a6c23.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080829005217.509a6c23.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Heiko-cy1Wll9GaHOsTnJN9+BGXg@public.gmane.org, Carstens <heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Andrew,

On Fri, 29 Aug 2008 00:52:17 -0700, Andrew Morton wrote:
> drivers/i2c/busses/i2c-ocores.c: In function 'oc_setreg':
> drivers/i2c/busses/i2c-ocores.c:68: error: implicit declaration of function 'iowrite8'
> drivers/i2c/busses/i2c-ocores.c: In function 'oc_getreg':
> drivers/i2c/busses/i2c-ocores.c:73: error: implicit declaration of function 'ioread8'
> drivers/i2c/busses/i2c-ocores.c: In function 'ocores_i2c_probe':
> drivers/i2c/busses/i2c-ocores.c:243: error: implicit declaration of function 'ioremap'
> drivers/i2c/busses/i2c-ocores.c:243: warning: assignment makes pointer from integer without a cast
> drivers/i2c/busses/i2c-ocores.c:279: error: implicit declaration of function 'iounmap'
> 
> Some missing Kconfig dependency.  s390 can't do IO :)

Where is this failure happening? In Linus' tree, I2C depends on
HAS_IOMEM (which s390 doesn't have), and I2C_OCORES depends on I2C. So
I fail to see how a make allmodconfig can select I2C_OCORES on s390.
Can you share the .config file?

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
