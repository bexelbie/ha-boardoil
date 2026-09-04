FROM ghcr.io/dozigden/boardoil:1.6.0

COPY BOARD_OIL_LICENSE /licenses/ha-boardoil/BoardOil-MIT.txt
COPY --chmod=755 run.sh /run.sh

ENTRYPOINT ["/run.sh"]
