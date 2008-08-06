From: Carlos Aguiar <carlos.aguiar-knKY8vlp0dIIdKJ7tpkyPg@public.gmane.org>
Subject: [PATCH 0/6] I2C: MENELAUS: Improvements on menelaus
Date: Wed, 06 Aug 2008 14:00:22 -0400
Message-ID: <4899E6B6.4090109@indt.org.br>
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

Hi folks,

The patch series that follows contains some improvements and changes on 
menelaus:

PATCH 1/6: synchronizes the menelaus code with linux-omap tree.

PATCH 2/6-5/6: continues synchronizing the menelaus code with linux-omap 
tree, but with modifications I just recently added:

- Use of macros instead of magic numbers
- Move menelaus header to include/linux/i2c/
- Move menelaus register map to include/linux/i2c/menelaus.h

PATCH 6/6: renames menelaus to twl92230:

- After some discussion at linux-omap mailing list, we thought a better 
idea (for more understandability) to change the menelaus files names to 
twl92230.


This patch series can be applied against most updated mainline tree.

BR,

Carlos.

PS: Thanks to Felipe Balbi for the hints and comments.

-- 
Carlos Eduardo Aguiar
Software Engineer
Mobile Linux Software
Nokia Institute of Technology - INdT
E-mail: carlos.aguiar-knKY8vlp0dIIdKJ7tpkyPg@public.gmane.org


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
