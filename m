From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Add disable runtime pm quirk
Date: Tue, 25 Jun 2019 16:38:37 +0300
Message-ID: <a3469010-829c-16dc-be83-6fe9b3021530@linux.intel.com>
References: <20190625083051.30332-1-acelan.kao@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625083051.30332-1-acelan.kao@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: AceLan Kao <acelan.kao@canonical.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 6/25/19 11:30 AM, AceLan Kao wrote:
> Dell machines come with goodix touchpad IC suffer from the double click
> issue if the Designware I2C adapter enters runtime suspend.
> 
> It's because the goodix re-assert the interrupt if host doesn't read the
> data within 100ms and designware takes a longer time to wake up from
> runtime suspend. In the case, it got a second interrupt during
> resuming, so it thinks it's a double click.
> 
> There is no simple way to fix this, it's a firmware issue and goodix
> agrees to fix this in their firmware on next release, but this issue
> still affects the machines that don't come with an updated firmware. So,
> add a quirk to mark those machines and avoid the designware from
> entering runtime suspend.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202683
> 
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> ---
>   drivers/i2c/busses/i2c-designware-master.c | 30 ++++++++++++++++++++--
>   1 file changed, 28 insertions(+), 2 deletions(-)
> 
I think better place to have this fixed is in 
drivers/hid/i2c-hid/i2c-hid-core.c by forcing the adapter device active 
when communicating with such touchpad.

In that way only bus where touchpad is connected stays active, not all 
and makes sure issue is handled also if that touchpad is ever connected 
to any other I2C adapter than Designware.

I did something similar in the commit 72bfcee11cf8 ("i2c: Prevent 
runtime suspend of adapter when Host Notify is required"). Not exactly 
same issue but similar idea.

By looking at i2c-hid-core.c I saw a few i2c-hid devices have 
I2C_HID_QUIRK_NO_RUNTIME_PM. Could you test how does this Goodix behave 
if only i2c-hid device runtime PM is prevented not I2C adapter?

A very quick test would be to comment out those lines below:

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c 
b/drivers/hid/i2c-hid/i2c-hid-core.c
index 90164fed08d3..bd3e6570c45e 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1156,8 +1156,8 @@ static int i2c_hid_probe(struct i2c_client *client,
  		goto err_mem_free;
  	}

-	if (!(ihid->quirks & I2C_HID_QUIRK_NO_RUNTIME_PM))
-		pm_runtime_put(&client->dev);
+//	if (!(ihid->quirks & I2C_HID_QUIRK_NO_RUNTIME_PM))
+//		pm_runtime_put(&client->dev);

  	return 0;

@@ -1183,8 +1183,8 @@ static int i2c_hid_remove(struct i2c_client *client)
  	struct i2c_hid *ihid = i2c_get_clientdata(client);
  	struct hid_device *hid;

-	if (!(ihid->quirks & I2C_HID_QUIRK_NO_RUNTIME_PM))
-		pm_runtime_get_sync(&client->dev);
+//	if (!(ihid->quirks & I2C_HID_QUIRK_NO_RUNTIME_PM))
+//		pm_runtime_get_sync(&client->dev);
  	pm_runtime_disable(&client->dev);
  	pm_runtime_set_suspended(&client->dev);
  	pm_runtime_put_noidle(&client->dev);

-- 
Jarkko
