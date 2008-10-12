From: "Wen Wang" <sickdoctor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Question about i2c new style modle
Date: Sun, 12 Oct 2008 14:35:49 +0800
Message-ID: <56458e0810112335r529622dei4c6891465c6fdf88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8353617792840431614=="
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

--===============8353617792840431614==
Content-Type: multipart/alternative;
	boundary="----=_Part_24747_270856.1223793349812"

------=_Part_24747_270856.1223793349812
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

 Currently I'm writing an i2c adapter driver and a client driver under
2.6.25 kernel, and I need to update those drivers into 2.6.27 kernel.

Can anyone please help to tell me if I have to upgrade my I2C client driver
from legacy binding model to new style binding model in 2.6.27 kernel or
not? If I have to :(, I don't know which part of code will update the board
info about I2C devices or this should be done by the client driver?

Can anyone please help to answer that?

Thanks
Wen

------=_Part_24747_270856.1223793349812
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><div>Hi all,</div>
<div>&nbsp;</div>
<div>
<div>Currently I&#39;m writing an i2c adapter driver and a client driver under 2.6.25 kernel, and I need to update those drivers into 2.6.27 kernel. </div>
<div>&nbsp;</div>
<div>Can anyone&nbsp;please help to&nbsp;tell me if&nbsp;I have to upgrade my I2C client driver from legacy binding&nbsp;model to new style binding model in 2.6.27 kernel or not? If I have to :(,&nbsp;I don&#39;t know&nbsp;which part of&nbsp;code will update the board info about I2C devices or this should be done by the client driver?</div>

<div>&nbsp;</div>
<div>Can anyone please help to answer that?</div>
<div>&nbsp;</div>
<div>Thanks</div>
<div>Wen</div></div></div>

------=_Part_24747_270856.1223793349812--


--===============8353617792840431614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============8353617792840431614==--
