From: Marco Aurelio da Costa <costa-nrw9SyMmU14AvxtiuMwx3w@public.gmane.org>
Subject: pca9665
Date: Wed, 17 Sep 2008 12:30:29 -0300
Message-ID: <48D12295.8080008@gamic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram.

I looked into the code for i2c-algo-pca.c and, if I don't want to 
implement the buffered mode (I can live without it for a while), the 
only changes I need to do are:
1. Implement the reset via parallel bus.
2. Change the way the i2c clock rate is treated, by passing the 
frequency directly instead of an index.

After this, this module could handle both chips. I need your advice:
Should I just duplicate all code and make the changes to this new algo 
or should I add a chip_type field to i2c_algo_pca_data and handle the 
chip on the existing algo code?

Thanks in advance,

Marco

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
