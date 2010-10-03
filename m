From: David Lutolf <david@lutolf.ch>
Subject: Re: [RFC PATCH 2/9] hwmon: lis3: regulator control
Date: Sun, 03 Oct 2010 13:53:57 +0200
Message-ID: <1286106837-a55c596ce45f55d605045cbc44a97e0b@lutolf.ch>
References: <4CA8672D.2070801@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lm-sensors-bounces@lm-sensors.org>
In-Reply-To: <4CA8672D.2070801@cam.ac.uk>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/options/lm-sensors>,
	<mailto:lm-sensors-request@lm-sensors.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/lm-sensors/>
List-Post: <mailto:lm-sensors@lm-sensors.org>
List-Help: <mailto:lm-sensors-request@lm-sensors.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/lm-sensors>,
	<mailto:lm-sensors-request@lm-sensors.org?subject=subscribe>
Sender: lm-sensors-bounces@lm-sensors.org
Errors-To: lm-sensors-bounces@lm-sensors.org
To: Jonathan Cameron <jic23@cam.ac.uk>, samu.p.onkalo@nokia.com
Cc: "eric.piel@tremplin-utc.net" <eric.piel@tremplin-utc.net>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

>> There are couple of bigger changes which somebody should do to this
>> driver:
>> - Change static lis3_dev structure to a dynamically allocated one//generalize
>Definitely.
>> - Add proper error handling to the driver.
>
>Agreed, hopefully someone will step up and do it (good job for a starting out
>kernel dev perhaps?)

If I'm given some guidance on how to do it I'll be glad to start. I don't have much experience in C but I should have the required knowledge..

what's the procedure now? should I just take the patch, fix it (hopefuly) and test inclusion in the latest kernel?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
