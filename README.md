# Prebuilt Kernel for Motorola Moto G73 5G (devonf)

This repository contains prebuilt kernel artifacts and loadable kernel modules for the **Motorola Moto G73 5G** (`devonf` / `XT2237-2`, MediaTek MT6855 / Dimensity 930), configured for **Paranoid Android (AOSPA) CLO-based** builds.

---

## Artifact Inventory

- **Kernel Image**: `Image.gz` (Linux `5.10.240-Tachyon`)
- **Board Devicetree**: `dtb/mt6855.dtb`
- **Stock DTBO Image**: `dtbo.img` (Stock signed 8 MB partition image from Motorola `U1TNS34.82-12-7-25` firmware baseline)
  - SHA-256: `da3b4938ea777bc03d89934b7a8fd9e8951da9fc84a60a0f5495fd7e6dc886ab`
  - *Note*: Stock signed DTBO is used exclusively. OSS DTBO building is omitted to avoid hardbrick risks.
- **Kernel Headers**: `kernel-headers/` (UAPI Linux headers for userspace HAL compilation)
- **Vendor Boot Modules**: `modules/vendor_boot/` (stripped modules loaded during early init/recovery)
- **Vendor DLKM Modules**: `modules/vendor_dlkm/` (stripped modules loaded during Android userspace init)

---

## Partition Mapping & Integration

| Component | Target Location | Build Variable |
|---|---|---|
| `Image.gz` | `boot.img` / `kernel` | `LOCAL_KERNEL` |
| `mt6855.dtb` | `boot.img` / `vendor_boot.img` | `BOARD_MKBOOTIMG_ARGS += --dtb` |
| `dtbo.img` | `dtbo.img` partition | `BOARD_PREBUILT_DTBOIMAGE` |
| `modules/vendor_boot/*.ko` | `vendor_boot.img` (ramdisk) | `BOARD_VENDOR_RAMDISK_KERNEL_MODULES` |
| `modules/vendor_dlkm/*.ko` | `vendor_dlkm.img` (`/vendor_dlkm/lib/modules/`) | `BOARD_VENDOR_KERNEL_MODULES` |

---

## Kernel Features & Configuration

- **Kernel Base**: Android Common Kernel (`android12-5.10`)
- **Defconfig**: `tachyon_defconfig`
- **Compiler**: Clang `r416183b` with ThinLTO enabled
- **AVB Integration**: Decoupled lock state reporting, compatible with Candidate v5 Little Kernel (`ro.boot.vbmeta.device_state = locked`, `ro.boot.verifiedbootstate = green`)
- **Dynamic Partitions**: EROFS root & subpartitions support
- **Module Signing**: Retains symbols for module loader; debug info stripped via `llvm-objcopy --strip-debug`

---

## Upstream Synchronization

To synchronize new kernel builds from `kernel-5.10`:
```bash
./build/build.sh
./script.sh
```
The script automatically copies `Image.gz`, `mt6855.dtb`, and strips modules into `modules/vendor_boot/` and `modules/vendor_dlkm/`.
