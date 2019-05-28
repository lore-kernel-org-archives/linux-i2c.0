From: "Adamski, Krzysztof (Nokia - PL/Wroclaw)"
        <krzysztof.adamski@nokia.com>
Subject: [PATCH] hwmon: pmbus: protect read-modify-write with lock
Date: Tue, 28 May 2019 09:08:21 +0000
Message-ID: <20190528090746.GA31184@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <3E7B0680287AFA4E9AFE88ABE2A0BAC9@eurprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

The operation done in the pmbus_update_fan() function is a
read-modify-write operation but it lacks any kind of lock protection
which may cause problems if run more than once simultaneously. This
patch uses an existing update_lock mutex to fix this problem.

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_c=
ore.c
index ef7ee90ee785..94adbede7912 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -268,6 +268,7 @@ int pmbus_update_fan(struct i2c_client *client, int pag=
e, int id,
 	int rv;
 	u8 to;
=20
+	mutex_lock(&data->update_lock);
 	from =3D pmbus_read_byte_data(client, page,
 				    pmbus_fan_config_registers[id]);
 	if (from < 0)
@@ -278,11 +279,15 @@ int pmbus_update_fan(struct i2c_client *client, int p=
age, int id,
 		rv =3D pmbus_write_byte_data(client, page,
 					   pmbus_fan_config_registers[id], to);
 		if (rv < 0)
-			return rv;
+			goto out;
 	}
=20
-	return _pmbus_write_word_data(client, page,
-				      pmbus_fan_command_registers[id], command);
+	rv =3D _pmbus_write_word_data(client, page,
+				    pmbus_fan_command_registers[id], command);
+
+out:
+	mutex_lock(&data->update_lock);
+	return rv;
 }
 EXPORT_SYMBOL_GPL(pmbus_update_fan);
=20
--=20
2.20.1
