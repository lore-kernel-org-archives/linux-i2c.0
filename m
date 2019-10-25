From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH 2/4] i2c: at91: implement i2c bus recovery
Date: Fri, 25 Oct 2019 09:14:00 +0800
Message-ID: <65d83bb0-9a0c-c6e2-1c58-cb421c69816c@electromag.com.au>
References: <20191002144658.7718-1-kamel.bouhara@bootlin.com>
 <20191002144658.7718-3-kamel.bouhara@bootlin.com>
 <20191021202044.GB3607@kunai>
 <724d3470-0561-1b3f-c826-bc16c74a8c0a@bootlin.com>
 <1e70ae35-052b-67cc-27c4-1077c211efd0@microchip.com>
 <20191024150726.GA1120@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191024150726.GA1120@kunai>
Content-Language: en-AU
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>, Codrin.Ciubotariu@microchip.com
Cc: kamel.bouhara@bootlin.com, alexandre.belloni@bootlin.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com, linux-i2c@vger.kernel.org, thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On 24/10/2019 23:07, Wolfram Sang wrote:
> 
>> So at the beginning of a new transfer, we should check if SDA (or SCL?)
>> is low and, if it's true, only then we should try recover the bus.
> 
> Yes, this is the proper time to do it. Remember, I2C does not define a
> timeout.
> 

FYI: Just a single poll at the start of the transfer, for it being low, will cause problems with multi-master buses.
Bus recovery should be attempted after a timeout when trying to communicate, even thou i2c doesn't define a timeout.

I'm trying to fix the designware drivers handling of this at the moment.

-- 
Regards
Phil Reid
