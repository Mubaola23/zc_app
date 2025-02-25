import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zurichat/constants/app_strings.dart';

import '../../../../models/start_dm_models.dart';
import '../../../../utilities/utilities.dart';
import 'custom_input_chip.dart';

class CustomChipInput extends StatelessWidget {
  const CustomChipInput({
    Key? key,
    required GlobalKey<ChipsInputState> chipKey,
    required this.mockResults,
  })  : _chipKey = chipKey,
        super(key: key);

  final GlobalKey<ChipsInputState> _chipKey;
  final List<UserModel> mockResults;
  final horizontalSpace = const SizedBox(width: 12);

  @override
  Widget build(BuildContext context) {
    return ChipsInput(
      key: _chipKey,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 10),
        border: InputBorder.none,
        prefixText: To,
        hintText: StartDmHint,
        hintStyle: GoogleFonts.lato(
          fontWeight: FontWeight.w400,
          fontSize: 16,

          //TODO CHange to brand colors
          color: const Color(0xFF999999),
        ),
      ),
      findSuggestions: (String query) {
        if (query.isNotEmpty) {
          final lowercaseQuery = query.toLowerCase();

          return mockResults.where((profile) {
            return profile.fullName!
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                profile.displayName!
                    .toLowerCase()
                    .contains(query.toLowerCase());
          }).toList(growable: false)
            ..sort((a, b) => a.fullName!
                .toLowerCase()
                .indexOf(lowercaseQuery)
                .compareTo(b.fullName!.toLowerCase().indexOf(lowercaseQuery)));
        }
        return mockResults;
      },
      onChanged: (data) {},
      chipBuilder: (context, state, UserModel profile) {
        return CustomInputChip(
            key: ObjectKey(profile),
            imageUrl: profile.imageUrl!,
            name: profile.displayName!);
      },
      suggestionBuilder: (context, state, UserModel profile) {
        return CheckboxListTile(
          key: ObjectKey(profile),
          value: false,
          onChanged: (bool? value) {
            if (value == true) {
              state.selectSuggestion(profile);
            }
          },
          secondary: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              image: DecorationImage(
                  image: makeNetworkImage(profile.imageUrl!),
                  fit: BoxFit.cover),
            ),
          ),
          title: Row(
            children: [
              Text(profile.displayName!,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black,
                  )),
              horizontalSpace,
              Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    //TODO Change to brand colors
                    color: profile.isOnline == true
                        ? const Color(0xFF007952)
                        : null,
                    shape: BoxShape.circle,
                    border: profile.isOnline == true
                        ? null

                        //TODO Change to brand colors
                        : Border.all(color: const Color(0xFF424141)),
                  )),
              horizontalSpace,
              Flexible(
                child: Text(profile.fullName!,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.black,
                    )),
              )
            ],
          ),
        );
      },
    );
  }
}
